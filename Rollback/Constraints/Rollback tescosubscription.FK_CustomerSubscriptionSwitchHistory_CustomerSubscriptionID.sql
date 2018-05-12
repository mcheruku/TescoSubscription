/*

	Author:			Robin
	Date created:	17-Jan-2013
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]'))
	BEGIN

		ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory] DROP CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] does not exist.'
	END
GO