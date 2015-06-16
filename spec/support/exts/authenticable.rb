class AbstractAuthObject; include Base; include Exts::Authenticable; end;
def authenticable
  it { should have_fields(:encrypted_password) }

  it { should validate_length_of(:password).within(4..40) }
  it { should validate_confirmation_of(:password) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }

  let!(:object) { klass.new }
  let!(:abstract_object) {
    ao = AbstractAuthObject.new;
    # ao.email    = 'test@test.com'
    ao.password = 'elpassword';
    ao.password_confirmation = 'elpassword';
    ao.save
    ao
  }

  describe 'password_required?' do
    it 'should be work' do
      object = klass.new
      expect(object.send(:password_required?)).to eq(false)
      object.password = 'elpassword'
      expect(object.send(:password_required?)).to eq(true)
    end
  end

  describe 'authenticable_salt' do
    it 'should be work' do
      object.password = 'elpassword'
      expect(object.authenticatable_salt).to eq(object.encrypted_password[0, 29])
    end
  end

  describe 'clean_up_passwords' do
    it 'should be work' do
      object.password = 'elpassword'
      object.password_confirmation = 'elpassword'
      object.clean_up_passwords
      expect(object.password).to eq(nil)
      expect(object.password_confirmation).to eq(nil)
    end
  end

  describe 'password=' do
    it 'should be set password and generate encrypted_password' do
      object.password = 'elpassword'
      expect(object.password).to eq('elpassword')
      expect(object.encrypted_password.present?).to eq(true)
    end
  end

  describe 'update_with_password' do
    it 'should be update if password valid' do
      expect(abstract_object.update_with_password(password: abstract_object.password)).to eq(true)
      expect(abstract_object.update_with_password(password: 'fail password')).to eq(false)
    end
  end

  describe 'update_without_password' do
    it 'should be not change pasword, only update attributes' do
      expect(abstract_object.update_without_password(password: 'invalid password')).to eq(true)
      expect(abstract_object.valid_password?('elpassword')).to eq(true)
    end
  end

  describe 'valid_password?' do
    it 'should be work' do
      expect(abstract_object.valid_password?('elpassword')).to eq(true)
      expect(abstract_object.valid_password?('invalid password')).to eq(false)
    end
  end

  describe 'set_random_password' do
    it 'should be set random password but not save' do
      abstract_object.set_random_password
      expect((abstract_object.password != 'elpassword')).to eq(true)
      expect(AbstractAuthObject.find(abstract_object.id).valid_password?('elpassword')).to eq(true)
    end
  end

  describe 'set_random_password!' do
    it 'should be set random password and save' do
      abstract_object.set_random_password!
      expect(AbstractAuthObject.find(abstract_object.id).valid_password?('elpassword')).to eq(false)
    end
  end
end
