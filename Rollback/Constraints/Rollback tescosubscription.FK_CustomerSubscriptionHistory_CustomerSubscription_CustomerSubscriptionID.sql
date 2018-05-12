/*

	Author:			Saritha Kommineni
	Date created:	23-Aug-2011
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/


IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID]') 
		AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistory]'))
	BEGIN

			ALTER TABLE [tescosubscription].[CustomerSubscriptionHistory] DROP CONSTRAINT FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID

			
IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistory]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] does not exist.'
	END
GO
