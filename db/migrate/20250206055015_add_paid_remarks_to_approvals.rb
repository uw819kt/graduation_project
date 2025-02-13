class AddPaidRemarksToApprovals < ActiveRecord::Migration[7.2]
  def change
    add_column :approvals, :paid_remarks, :text
  end
end
