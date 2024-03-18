# Engine API -- Prague

Engine API changes introduced in Prague.

This specification is based on and extends [Engine API - Cancun](./cancun.md) specification.

## Table of contents

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Engine API -- Prague](#engine-api----prague)
  - [Table of contents](#table-of-contents)
  - [Structures](#structures)
    - [ExitV1](#exitv1)
    - [ExecutionPayloadV4](#executionpayloadv4)
  - [Methods](#methods)
    - [engine\_newPayloadV4](#engine_newpayloadv4)
      - [Request](#request)
      - [Response](#response)
      - [Specification](#specification)
    - [engine\_getPayloadV4](#engine_getpayloadv4)
      - [Request](#request-1)
      - [Response](#response-1)
      - [Specification](#specification-1)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Structures

### ExitV1

This structure represents an execution layer triggered exit operation.
The fields are encoded as follows:

- `sourceAddress`: `DATA`, 20 Bytes
- `validatorPublicKey`: `DATA`, 48 Bytes

### ExecutionPayloadV4

This structure has the syntax of [`ExecutionPayloadV3`](./cancun.md#executionpayloadv3) and appends the new field: `exits`.

- `parentHash`: `DATA`, 32 Bytes
- `feeRecipient`:  `DATA`, 20 Bytes
- `stateRoot`: `DATA`, 32 Bytes
- `receiptsRoot`: `DATA`, 32 Bytes
- `logsBloom`: `DATA`, 256 Bytes
- `prevRandao`: `DATA`, 32 Bytes
- `blockNumber`: `QUANTITY`, 64 Bits
- `gasLimit`: `QUANTITY`, 64 Bits
- `gasUsed`: `QUANTITY`, 64 Bits
- `timestamp`: `QUANTITY`, 64 Bits
- `extraData`: `DATA`, 0 to 32 Bytes
- `baseFeePerGas`: `QUANTITY`, 256 Bits
- `blockHash`: `DATA`, 32 Bytes
- `transactions`: `Array of DATA` - Array of transaction objects, each object is a byte list (`DATA`) representing `TransactionType || TransactionPayload` or `LegacyTransaction` as defined in [EIP-2718](https://eips.ethereum.org/EIPS/eip-2718)
- `withdrawals`: `Array of WithdrawalV1` - Array of withdrawals, each object is an `OBJECT` containing the fields of a `WithdrawalV1` structure.
- `blobGasUsed`: `QUANTITY`, 64 Bits
- `excessBlobGas`: `QUANTITY`, 64 Bits
- `exits`: `Array of ExitV1` - Array of exits, each object is an `OBJECT` containing the fields of a `ExitV1` structure.

## Methods

### engine_newPayloadV4

The request of this method is updated with [`ExecutionPayloadV4`](#ExecutionPayloadV4).

#### Request

* method: `engine_newPayloadV4`
* params:
  1. `executionPayload`: [`ExecutionPayloadV4`](#ExecutionPayloadV4).
  2. `expectedBlobVersionedHashes`: `Array of DATA`, 32 Bytes - Array of expected blob versioned hashes to validate.
  3. `parentBeaconBlockRoot`: `DATA`, 32 Bytes - Root of the parent beacon block.

#### Response

Refer to the response for [`engine_newPayloadV3`](./cancun.md#engine_newpayloadv3).

#### Specification

This method follows the same specification as [`engine_newPayloadV3`](./cancun.md#engine_newpayloadv3).

### engine_getPayloadV4

The response of this method is updated with [`ExecutionPayloadV4`](#ExecutionPayloadV4).

#### Request

* method: `engine_getPayloadV4`
* params:
  1. `payloadId`: `DATA`, 8 Bytes - Identifier of the payload build process
* timeout: 1s

#### Response

* result: `object`
  - `executionPayload`: [`ExecutionPayloadV4`](#ExecutionPayloadV4)
  - `blockValue` : `QUANTITY`, 256 Bits - The expected value to be received by the `feeRecipient` in wei
  - `blobsBundle`: [`BlobsBundleV1`](#BlobsBundleV1) - Bundle with data corresponding to blob transactions included into `executionPayload`
  - `shouldOverrideBuilder` : `BOOLEAN` - Suggestion from the execution layer to use this `executionPayload` instead of an externally provided one
* error: code and message set in case an exception happens while getting the payload.

#### Specification

Refer to the specification for [`engine_getPayloadV3`](./cancun.md#engine_getpayloadv3).