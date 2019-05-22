shared_examples 'without an authenticated user' do
  context 'without an authenticated user' do
    let(:current_user) { build_stubbed(:user) }

    before { http_response }

    it { is_expected.to have_http_status :unauthorized }
  end
end
