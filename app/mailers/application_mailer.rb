class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  # def send_confirm_to_user(user)
  #   @user = user
  #   mail(
  #     subject: "画像登録が完了しました。", #メールのタイトル
  #     to: @user.email #宛先
  #   ) do |format|
  #     format.text
  #   end
  # end

end
