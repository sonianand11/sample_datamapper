class Comment
  include Tire::Model::Search
  include DataMapper::Resource
  
  property :id, Serial
  property :title, String
  property :description, Text
  property :picture_id, Integer
  property :type, String, :default => "comment"
  
  belongs_to :picture, :touch => true  
  
  #Search in elasticsearch
  def self.search q
  
    begin
      result = tire.search do
        query {string ("picture_id:#{q}")}
      end
      return result.any? ? result : Comment.all(:picture_id => q)
    rescue Exception => e
      puts "Exception in search Comments: #{e.message}"
      Comment.all(:picture_id => q) #if any exception then return from database
    end
    
  end

  #Storing in elasticsearch
  def self.store_to_elasticsearch comment
    Tire.index "comments" do
      store comment.attributes
      refresh
    end
  end
  
end
