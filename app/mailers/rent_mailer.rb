class RentMailer < ApplicationMailer
  def notification_mail(rent)
    @rent = rent
    @user = @rent.user

    I18n.with_locale(user_locale(@user)) do
      mail(to: @user.email, subject: t('rent_notification_mail.subject'))
    end
  end

  def expiration_mail(rent)
    @rent = rent
    user = rent.user
    I18n.with_locale(user_locale(user)) do
      mail(to: user.email, subject: t('rent_expiration_mail.title'))
    end
  end

  private

  def user_locale(user)
    locale = user.locale.downcase.to_sym
    I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end
end
