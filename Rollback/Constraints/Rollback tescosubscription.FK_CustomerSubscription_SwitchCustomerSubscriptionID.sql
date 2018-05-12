/*

	Author:			Robin
	Date created:	16 Jan 2013
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_CustomerSubscription_SwitchCustomerSubscriptionID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerSubscription_SwitchCustomerSubscriptionID]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]'))
	BEGIN

		ALTER TABLE [tescosubscription].[CustomerSubscription] DROP CONSTRAINT [FK_CustomerSubscription_SwitchCustomerSubscriptionID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerSubscription_SwitchCustomerSubscriptionID]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_CustomerSubscription_SwitchCustomerSubscriptionID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_CustomerSubscription_SwitchCustomerSubscriptionID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_CustomerSubscription_SwitchCustomerSubscriptionID] does not exist.'
	END
GO
