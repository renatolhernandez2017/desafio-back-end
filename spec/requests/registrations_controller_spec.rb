require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe 'POST #create' do
    let(:params) do
      {
        account: {
          name: 'Conta Teste',
          from_partner: true,
          users: [{
            email: 'user@test.com',
            first_name: 'User',
            last_name: 'Test',
            phone: '62999999999'
          }]
        }
      }
    end

    it 'retorna sucesso' do
      service = instance_double(CreateAccount)

      expect(CreateAccount)
        .to receive(:new)
        .with(kind_of(ActionController::Parameters))
        .and_return(service)

      expect(service).to receive(:call)

      post :create, params: params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Registro realizado com sucesso'
      )
    end

    it 'retorna erro quando o service falha' do
      allow(CreateAccount)
        .to receive(:new)
        .and_raise(ActiveRecord::RecordInvalid.new(Account.new))

      post :create, params: params

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
