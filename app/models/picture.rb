class Picture

  include DataMapper::Resource
  include Paperclip::Resource
  
  property :id, Serial
  property :title, String
  property :description, Text
  
  has_attached_file :image, 
                    :styles => { :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"
                    
  has n, :comments, :dependent => :destroy
end
