require 'spec_helper'

describe Book do
  describe 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:image_url) }
    it { should validate_presence_of(:goodreads_url) }
  end
end
