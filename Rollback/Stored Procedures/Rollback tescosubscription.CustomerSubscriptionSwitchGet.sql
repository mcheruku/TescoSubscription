/*

	Author:			Robin
	Date created:	12 Mar 2013
	Purpose:		Rollback Procedure tescosubscription.CustomerSubscriptionSwitchGet 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'tescosubscription.CustomerSubscriptionSwitchGet ',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE tescosubscription.CustomerSubscriptionSwitchGet 

		IF OBJECT_ID(N'tescosubscription.CustomerSubscriptionSwitchGet ',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure tescosubscription.CustomerSubscriptionSwitchGet  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure tescosubscription.CustomerSubscriptionSwitchGet  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure tescosubscription.CustomerSubscriptionSwitchGet  does not exist.'
	END
GO
