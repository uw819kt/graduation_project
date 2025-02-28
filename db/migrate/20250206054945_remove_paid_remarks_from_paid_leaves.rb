class RemovePaidRemarksFromPaidLeaves < ActiveRecord::Migration[7.2]
  def change
    remove_column :paid_leaves, :paid_remarks, :text
  end
end
