# Shard Blob Extension

This is an extension specific to [EIP-4844](https://eips.ethereum.org/EIPS/eip-4844) to the `core` methods as defined in the [Engine API](./specification.md).
This extension is backwards-compatible, but not part of the initial Engine API.

## Structures

### BlobsBundleV1

The fields are encoded as follows:

- `blockHash`: `DATA`, 32 Bytes
- `kzgs`: `Array of DATA` - Array of `KZGCommitment` as defined in [EIP-4844](https://eips.ethereum.org/EIPS/eip-4844), 48 bytes each (`DATA`).
- `blobs`: `Array of DATA` - Array of blobs, each blob is `FIELD_ELEMENTS_PER_BLOB * size_of(BLSFieldElement) = 4096 * 32 = 131072` bytes (`DATA`) representing a SSZ-encoded `Blob` as defined in [EIP-4844](https://eips.ethereum.org/EIPS/eip-4844)

## Methods

### engine_getBlobsBundleV1

This method retrieves the blobs and their respective KZG commitments corresponding to the `versioned_hashes`
included in the blob transactions of the referenced execution payload.

This method may be combined with `engine_getPayloadV1` into a `engine_getPayloadV2` in a later stage of EIP-4844.
The separation of concerns aims to minimize changes during the testing phase of the EIP.

#### Request

* method: `engine_getBlobsBundleV1`
* params:
  1. `payloadId`: `DATA`, 8 Bytes - Identifier of the payload build process

#### Response

* result: [`BlobsBundleV1`](#BlobsBundleV1)
* error: code and message set in case an exception happens while getting the blobs bundle.

#### Specification

1. Given the `payloadId` client software **MUST** return the blobs bundle corresponding to the most recent version of the payload that was served with `engine_getPayload`, if any,
   and halt any further changes to the payload. The `engine_getBlobsBundleV1` and `engine_getPayloadV1` results **MUST** be consistent as outlined in items 3, 4 and 5 below. 

2. The call **MUST** return `-32001: Unknown payload` error if the build process identified by the `payloadId` does not exist. Note that a payload without any blobs **MUST** return an empty `blobs` and `kzgs` list, not an error.

3. The call **MUST** return `kzgs` matching the versioned hashes of the transactions list of the execution payload, in the same order,
   i.e. `assert verify_kzgs_against_transactions(payload.transactions, bundle.kzgs)` (see EIP-4844 consensus-specs).

4. The call **MUST** return `blobs` that match the `kzgs` list, i.e. `assert len(kzgs) == len(blobs) and all(blob_to_kzg(blob) == kzg for kzg, blob in zip(bundle.kzgs, bundle.blobs))`

5. The call **MUST** return `blockHash` to reference the `blockHash` of the corresponding execution payload, intended for the caller to sanity-check the consistency with the `engine_getPayload` call.
