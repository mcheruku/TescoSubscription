/*

	Created By:		Robin
	Date created:   12-May-2014
	Purpose:		ROLLBACK script for function [dbo].[ConvertListToTable]

	--Modifications History--
	Changed On	Changed By		Defect		Description
          
*/

IF OBJECT_ID(N'[dbo].[ConvertListToTable]', N'FN') IS NOT NULL
	BEGIN
		
		DROP FUNCTION [dbo].[ConvertListToTable]
		
		IF OBJECT_ID(N'[dbo].[ConvertListToTable]', N'FN') IS NULL
			BEGIN
				PRINT 'SUCCESS - Function [dbo].[ConvertListToTable] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Function [dbo].[ConvertListToTable] not dropped.',16,1)
			END
			
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Function [dbo].[ConvertListToTable] does not exist.'
	END

GO