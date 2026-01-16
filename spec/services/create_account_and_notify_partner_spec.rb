RSpec.describe CreateAccountAndNotifyPartner do
  describe "#call" do
    subject(:call) { described_class.call(params) }

    let(:params) { { name: "Fintera - New Account", users: users } }
    let(:fake_result) { ApplicationService::Result.new(true, instance_double(Account)) }

    context "when some user is from fintera" do
      let(:users) { [{ email: Faker::Internet.email(domain: "fintera.com.br") }] }

      it "creates a new account and notifies partner with correct fintera flag" do
        expect(CreateAccount).to receive(:call).with(params, true).and_return(fake_result)
        expect(NotifyPartner).to receive_message_chain(:new, :perform)

        call
      end
    end

    context "when users are not from fintera" do
      let(:users) { [{ email: Faker::Internet.email(domain: "example.com") }] }

      it "creates a new account and notifies partner with correct flag" do
        expect(CreateAccount).to receive(:call).with(params, false).and_return(fake_result)
        expect(NotifyPartner).to receive_message_chain(:new, :perform)

        call
      end
    end
  end
end