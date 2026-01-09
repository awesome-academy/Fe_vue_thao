# frozen_string_literal: true

class TransactionService
  def record(student_id, class_id, params)
    transaction = Transaction.new(student_id:, class_id:,
                                  **params)

    if transaction.save
      Result.success(transaction)
    else
      Result.failure(transaction.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def update(transaction, params)
    if transaction.update(params)
      Result.success(transaction)
    else
      Result.failure(transaction.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def delete(transaction)
    if transaction.destroy
      Result.success({ message: 'Transaction deleted successfully' })
    else
      Result.failure(transaction.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def get_student_transactions(student_id)
    transactions = Transaction.where(student_id:).order(payment_date: :desc)
    Result.success(transactions)
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def get_revenue(class_id, month = nil, year = nil)
    query = Transaction.where(class_id:).where(status: 'Completed')

    query = query.by_month(month, year) if month && year

    total = query.sum(:amount)
    Result.success({ total:, count: query.count })
  rescue StandardError => e
    Result.failure({ error: e.message })
  end
end
