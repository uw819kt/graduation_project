class AddPaidRemarksToRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :requests, :paid_remarks, :text
  end
end
