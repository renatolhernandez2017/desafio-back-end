module Api
  module V1
    class RegistrationsController < ApplicationController
      def create
        CreateAccount.new(create_params).call
        render json: { message: 'Registro realizado com sucesso' }, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      private

      def create_params
        params.require(:account)
              .permit(:name, :from_partner, :many_partners,
                entities: [:name, { users: %i[email first_name last_name phone] }]
              )
      end
    end
  end
end
