PRINT 'Before TRY/CATCH block.';

BEGIN TRY
  PRINT '  Entering TRY block.';
  INSERT INTO dbo.Employees(empid, empname, mgrid)
    VALUES(2, 'Emp2', 1);
  -- Also try with empid = 0, 'A', NULL
  PRINT '    After INSERT.';

  PRINT '  Exiting TRY block.';
END TRY
BEGIN CATCH
  PRINT '  Entering CATCH block.';
  IF ERROR_NUMBER() = 2627
  BEGIN
    PRINT '    Handling PK violation...';
  END
  ELSE IF ERROR_NUMBER() = 547
  BEGIN
    PRINT '    Handling CHECK/FK constraint violation...';
  END
  ELSE IF ERROR_NUMBER() = 515
  BEGIN
    PRINT '    Handling NULL violation...';
  END
  ELSE IF ERROR_NUMBER() = 245
  BEGIN
  PRINT '    Handling conversion error...';
  END
  ELSE
  BEGIN
    PRINT '    Handling unknown error...';
  END

  PRINT '    Error Number  : ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
  PRINT '    Error Message : ' + ERROR_MESSAGE();
  PRINT '    Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
  PRINT '    Error State   : ' + CAST(ERROR_STATE() AS VARCHAR(10));
  PRINT '    Error Line    : ' + CAST(ERROR_LINE() AS VARCHAR(10));
  PRINT '    Error Proc    : ' + ISNULL(ERROR_PROCEDURE(), 'Not within proc');

  PRINT '  Exiting CATCH block.';

END CATCH

PRINT 'After TRY/CATCH block.';
