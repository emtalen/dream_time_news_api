RSpec.describe Admin, type: :model do
  it "is expected to have valid Factory" do
    expect(create(:admin)).to be_valid
  end

  describe "Database table" do
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :tokens }
    it { is_expected.to have_db_column :name }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_confirmation_of :password }
  end
end
