require 'rails_helper'

RSpec.describe CreateAccount do
  subject(:service) { described_class.new(params) }

  let(:params) do
    {
      name: 'Empresa Z',
      entities: [
        {
          name: 'Empresa A',
          users: [
            {
              email: 'teste@empresa.com',
              first_name: 'Teste',
              last_name: 'Silva',
              phone: '62999999999'
            }
          ]
        },
        {
          name: 'Empresa B',
          users: [
            {
              email: 'teste@empresa.com',
              first_name: 'Teste',
              last_name: 'Silva',
              phone: '62999999999'
            }
          ]
        }
      ]
    }
  end

  describe '#call' do
    it 'cria conta, entities e usuários corretamente' do
      expect {
        described_class.new(params).call
      }.to change(Account, :count).by(1)
        .and change(Entity, :count).by(2)
        .and change(User, :count).by(1)
    end

    it 'não duplica usuário ao associar a múltiplas entities' do
      described_class.new(params).call

      user = User.find_by(email: 'teste@empresa.com')

      expect(user.entities.pluck(:name)).to contain_exactly(
        'Empresa A',
        'Empresa B'
      )
    end

    it 'não quebra ao receber a mesma requisição duas vezes' do
      service = described_class.new(params)

      service.call
      expect { service.call }.not_to change(User, :count)
    end

    it 'faz rollback se uma entity falhar' do
      invalid_params = params.deep_dup
      invalid_params[:entities][0][:name] = nil

      expect {
        described_class.new(invalid_params).call
      }.to raise_error(ActiveRecord::RecordInvalid)
      .and change(Account, :count).by(0)
      .and change(Entity, :count).by(0)
      .and change(User, :count).by(0)
    end

    it 'faz rollback se um usuário falhar' do
      invalid_params = params.deep_dup
      invalid_params[:entities][0][:users][0][:email] = nil

      expect {
        described_class.new(invalid_params).call
      }.to raise_error(ActiveRecord::RecordInvalid)
      .and change(Account, :count).by(0)
      .and change(Entity, :count).by(0)
      .and change(User, :count).by(0)
    end
  end
end
