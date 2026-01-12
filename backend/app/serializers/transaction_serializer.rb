# frozen_string_literal: true

class TransactionSerializer
  def initialize(transaction)
    @transaction = transaction
  end

  def serialize
    {
      id: @transaction.id,
      student_id: @transaction.student_id,
      student_name: @transaction.student.full_name,
      class_id: @transaction.class_id,
      class_name: @transaction.class.name,
      amount: @transaction.amount,
      payment_date: @transaction.payment_date,
      payment_method: @transaction.payment_method,
      status: @transaction.status,
      note: @transaction.note,
      created_at: @transaction.created_at,
      updated_at: @transaction.updated_at
    }
  end

  def self.serialize(transaction)
    new(transaction).serialize
  end
end
