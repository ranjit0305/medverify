import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class TransactionManager {
  final Web3Client _client;
  final String _rpcUrl;
  final String _contractAddress;
  late final DeployedContract _contract;
  late final ContractFunction _initiateTransaction;
  late final ContractFunction _getBatchDetails;

  TransactionManager(this._rpcUrl, this._contractAddress)
      : _client = Web3Client(_rpcUrl, Client()) {
    _initializeContract();
  }

  void _initializeContract() async {
    // Load the ABI file
    final abiJson = json.decode(await rootBundle.loadString('assets/abi/contract_abi.json'));
    final contract = DeployedContract(
      ContractAbi.fromJson(abiJson, 'MedVerify'),
      EthereumAddress.fromHex(_contractAddress),
    );
    _contract = contract;

    // Initialize contract functions
    _initiateTransaction = contract.function('initiateTransaction');
    _getBatchDetails = contract.function('getBatchDetails');
  }

  Future<void> initiateTransaction(String receiver, BigInt amount, String privateKey) async {
    final credentials = EthPrivateKey.fromHex(privateKey);
    final senderAddress = await credentials.extractAddress();
    
    final transaction = Transaction.callContract(
      contract: _contract,
      function: _initiateTransaction,
      parameters: [EthereumAddress.fromHex(receiver), amount],
    );

    await _client.sendTransaction(
      credentials,
      transaction,
      chainId: 1337, // Use your chain's ID
      fetchChainIdFromNetworkId: true,
    );
  }

  Future<void> getBatchDetails() async {
    final result = await _client.call(
      contract: _contract,
      function: _getBatchDetails,
      params: [],
    );
    // Process result
  }
}
