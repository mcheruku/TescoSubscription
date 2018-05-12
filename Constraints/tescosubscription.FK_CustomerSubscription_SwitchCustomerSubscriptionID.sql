/*

	Author:			Robin John
	Date created:	07-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerSubscription] and [tescosubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL 
		
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_SwitchCustomerSubscriptionID')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_SwitchCustomerSubscriptionID] FOREIGN KEY([SwitchCustomerSubscriptionID])
REFERENCES [tescosubscription].[CustomerSubscription] ([CustomerSubscriptionID])

ALTER TABLE [tescosubscription].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_SwitchCustomerSubscriptionID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_SwitchCustomerSubscriptionID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscription_SwitchCustomerSubscriptionID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscription_SwitchCustomerSubscriptionID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscription_SwitchCustomerSubscriptionID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[CustomerSubscription]/[tescosubscription].[CustomerSubscription] does not exist.',16,1)
	END
GO

GO