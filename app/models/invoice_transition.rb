class InvoiceTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition


  belongs_to :invoice#, inverse_of: :invoice_transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = invoice.invoice_transitions.order(:sort_key).last
    return unless last_transition.present?
    last_transition.update_column(:most_recent, true)
  end
end
