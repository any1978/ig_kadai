class ContactMailer < ApplicationMailer
    def contact_mail(contact)
        @contact = contact
        mail to: "katsuhiro.tsukinoki@gmail.com", subject: "画像投稿確認メール"
    end
end
