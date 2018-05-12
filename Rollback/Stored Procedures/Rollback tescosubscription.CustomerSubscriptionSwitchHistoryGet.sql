/*

	Author:			Robin
	Date created:	28-Feb-2013
	Purpose:		Rollback Procedure tescosubscription.CustomerSubscriptionSwitchHistoryGet 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'tescosubscription.CustomerSubscriptionSwitchHistoryGet ',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE tescosubscription.CustomerSubscriptionSwitchHistoryGet 

		IF OBJECT_ID(N'tescosubscription.CustomerSubscriptionSwitchHistoryGet ',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure tescosubscription.CustomerSubscriptionSwitchHistoryGet  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure tescosubscription.CustomerSubscriptionSwitchHistoryGet  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure tescosubscription.CustomerSubscriptionSwitchHistoryGet  does not exist.'
	END
GO
