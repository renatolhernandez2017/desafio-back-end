RSpec.describe Entity, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:entity_users) }
  it { should have_many(:users).through(:entity_users) }
end
