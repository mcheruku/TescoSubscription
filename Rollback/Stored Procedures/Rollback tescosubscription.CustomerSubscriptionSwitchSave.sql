/*

	Author:			Robin
	Date created:	24-Jan-2013
	Purpose:		Rollback Procedure tescosubscription.CustomerSubscriptionSwitchSave 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'tescosubscription.CustomerSubscriptionSwitchSave ',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE tescosubscription.CustomerSubscriptionSwitchSave 

		IF OBJECT_ID(N'tescosubscription.CustomerSubscriptionSwitchSave ',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure tescosubscription.CustomerSubscriptionSwitchSave  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure tescosubscription.CustomerSubscriptionSwitchSave  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure tescosubscription.CustomerSubscriptionSwitchSave  does not exist.'
	END
GO
