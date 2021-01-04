class ArticlesSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :image

  def image
    return nil unless object.image.attached?
    object.image_path
  end
end
