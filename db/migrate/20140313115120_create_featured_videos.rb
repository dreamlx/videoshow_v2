class CreateFeaturedVideos < ActiveRecord::Migration
  def change
    create_table :featured_videos do |t|

      t.timestamps
    end
  end
end
