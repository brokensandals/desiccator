class RenameReviewersToReviewerStatuses < ActiveRecord::Migration
  def up
    rename_table :reviewers, :reviewer_statuses
  end

  def down
    rename_table :reviewer_statuses, :reviewers
  end
end
