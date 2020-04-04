class UsernotifierMailer < ApplicationMailer

    def send_submit_email(contact)
        @contact = @blog
        mail to: "katsuhiro.tsukinoki@gmail.com", subject: "Thanks for Submit for blogapp"
       
    end
    

end


# class ContactMailer < ApplicationMailer
#     def contact_mail(contact)
#         @contact = contact
#         mail to: "katsuhiro.tsukinoki@gmail.com", subject: "お問い合わせの確認メール"
#     end
# end

# <h1>お問い合わせが完了しました！</h1>
# <h4>name: <%= @contact.name %></h4>
# <h4>お問い合わせ内容の確認</h4>
# <p>content: <%= @contact.content %></p>