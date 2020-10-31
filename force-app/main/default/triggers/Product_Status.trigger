trigger Product_Status on Asset (after update) {
	NotificationEmail.sendMail(Trigger.New);
}