FactoryBot.define do
  factory :entity do
    name { 'Empresa Teste' }
    account_id { create(:account).id }
  end
end
