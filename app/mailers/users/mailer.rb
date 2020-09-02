# frozen_string_literal: true

class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'
  def confirmation_instructions(record, token, opts = {})
    opts[:subject] =
      if record.unconfirmed_email.nil?
        '【Bookers】会員登録完了'
      else
        '【Bookers】メールアドレス変更手続きを完了してください'
      end
    super
  end
end
