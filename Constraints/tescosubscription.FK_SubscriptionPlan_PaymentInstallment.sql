/*

	Author:			Robin John
	Date created:	19-Dec-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[PaymentInstallment] and [tescosubscription].[SubscriptionPlan]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PaymentInstallment]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_PaymentInstallment')
			BEGIN

				ALTER TABLE [tescosubscription].[SubscriptionPlan]  WITH NOCHECK ADD  CONSTRAINT [FK_SubscriptionPlan_PaymentInstallment] FOREIGN KEY([PaymentInstallmentID])
				REFERENCES [tescosubscription].[PaymentInstallment] ([PaymentInstallmentID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[SubscriptionPlan] CHECK CONSTRAINT [FK_SubscriptionPlan_PaymentInstallment]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_PaymentInstallment')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_SubscriptionPlan_PaymentInstallment] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_SubscriptionPlan_PaymentInstallment] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_SubscriptionPlan_PaymentInstallment] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[PaymentInstallment]/[tescosubscription].[SubscriptionPlan] does not exist.',16,1)
	END
GO
