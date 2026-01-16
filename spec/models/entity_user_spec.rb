RSpec.describe EntityUser, type: :model do
  it { should belong_to(:entity) }
  it { should belong_to(:user) }

  describe "validations" do
    subject { build(:entity_user) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:entity_id) }
  end
end
