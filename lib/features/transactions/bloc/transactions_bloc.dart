import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kharach_guru/data/models/transaction.dart';
import 'package:kharach_guru/data/repository/transaction_repository.dart';

// --- EVENTS ---
// The events that the BLoC can receive
abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
  @override
  List<Object> get props => [];
}

class LoadTransactions extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;
  const AddTransaction(this.transaction);
  @override
  List<Object> get props => [transaction];
}

class DeleteTransaction extends TransactionEvent {
  final int index;
  const DeleteTransaction(this.index);
  @override
  List<Object> get props => [index];
}

// --- STATES ---
// The possible states of the BLoC
enum TransactionStatus { initial, loading, success, failure }

class TransactionState extends Equatable {
  final List<Transaction> transactions;
  final TransactionStatus status;

  const TransactionState({
    this.transactions = const [],
    this.status = TransactionStatus.initial,
  });

  @override
  List<Object> get props => [transactions, status];

  TransactionState copyWith({
    List<Transaction>? transactions,
    TransactionStatus? status,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      status: status ?? this.status,
    );
  }
}

// --- BLOC ---
// The main logic that processes events and emits states
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;

  TransactionBloc(this._transactionRepository) : super(const TransactionState()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
  }

  void _onLoadTransactions(
      LoadTransactions event, Emitter<TransactionState> emit) {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      final transactions = _transactionRepository.getAllTransactions();
      emit(state.copyWith(
          status: TransactionStatus.success, transactions: transactions));
    } catch (_) {
      emit(state.copyWith(status: TransactionStatus.failure));
    }
  }

  Future<void> _onAddTransaction(
      AddTransaction event, Emitter<TransactionState> emit) async {
    await _transactionRepository.addTransaction(event.transaction);
    add(LoadTransactions()); // Reload the list after adding
  }

  Future<void> _onDeleteTransaction(
      DeleteTransaction event, Emitter<TransactionState> emit) async {
    await _transactionRepository.deleteTransaction(event.index);
    add(LoadTransactions()); // Reload the list after deleting
  }
}