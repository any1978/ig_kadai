class UserNotifierMailer < ApplicationMailer

    default :from => 'from@example.com'

    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_submit_email(contact)
        @contact = contact
        mail to: "katsuhiro.tsukinoki@gmail.com", subject: "Thanks for Submit for blogapp"
       
    end

end
