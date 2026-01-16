class CreateAccount < ApplicationService
  def initialize(params)
    @params = params
  end

  def call
    ActiveRecord::Base.transaction do
      account = create_account!
      create_entities!(account)
      account
    end
  end

  private

  def create_account!
    Account.create!(account_params)
  end

  def create_entities!(account)
    raise ActiveRecord::RecordInvalid, account if entities_params.blank?

    entities_params.each do |entity_params|
      entity = account.entities.create!(name: entity_params[:name])
      associate_users!(entity, entity_params[:users])
    end
  end

  def associate_users!(entity, users)
    raise ActiveRecord::RecordInvalid, entity if users.blank?

    Array(users).each do |user_params|
      user = find_or_create_user!(user_params)

      entity.users << user unless entity.users.exists?(user.id)
    end
  end

  def find_or_create_user!(params)
    User.find_or_create_by!(email: params[:email]) do |user|
      user.first_name = params[:first_name]
      user.last_name  = params[:last_name]
      user.phone      = params[:phone]
    end
  end

  def account_params
    @params.slice(:name)
  end

  def entities_params
    @params[:entities] || []
  end
end
