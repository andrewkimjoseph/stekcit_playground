const nodemailer = await import ("nodemailer");


const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_ADDRESS,
    pass: process.env.GMAIL_APP_PASSWORD,
  },
});

// Firebase Cloud Function to send an email
exports.sendEmail = functions.https.onCall((data, context) => {
  const { subject, message } = data;

  const mailOptions = {
    from: process.env.EMAIL_ADDRESS,
    to: process.env.EMAIL_ADDRESS,
    subject: subject,
    text: message,
  };

  return transporter
    .sendMail(mailOptions)
    .then(() => {
      console.log("Email sent successfully");
      return { success: true };
    })
    .catch((error) => {
      console.error("Error sending email:", error);
      return { success: false, error: error.message };
    });
});