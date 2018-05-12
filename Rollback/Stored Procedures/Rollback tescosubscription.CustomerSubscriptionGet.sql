/*

	Author:			Robin
	Date created:	28-Feb-2013
	Purpose:		Rollback Procedure tescosubscription.CustomerSubscriptionGet 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'tescosubscription.CustomerSubscriptionGet ',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE tescosubscription.CustomerSubscriptionGet 

		IF OBJECT_ID(N'tescosubscription.CustomerSubscriptionGet ',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure tescosubscription.CustomerSubscriptionGet  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure tescosubscription.CustomerSubscriptionGet  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure tescosubscription.CustomerSubscriptionGet  does not exist.'
	END
GO
