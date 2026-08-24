# StructuredUseCases Library — Cameo Test Procedure

## Purpose

Verify that the renamed `StructuredUseCases` library loads and behaves in Cameo exactly as the previously working `SimpleUseCases` library.

The library itself is unchanged except for the package name:

`SimpleUseCases` → `StructuredUseCases`

## Files

1. `StructuredUseCases_from_working_UC_Lib.sysml`
2. `StructuredUseCases_TestSuite_matching.sysml`

## Procedure

1. Open Cameo with the SysML v2 plugin installed.
2. Create or open a clean SysML v2 test project.
3. Load `StructuredUseCases_from_working_UC_Lib.sysml` in the SysML v2 Textual Editor.
4. Synchronize the library using `Alt+S`.
5. Verify that the library compiles without errors.
6. In the Containment tree, verify that `StructuredUseCases` contains:
   - `Actor`
   - `Step`
   - `Scenario`
   - `UseCase`
   - `Association`
   - `UseCaseDiagram`
   - `useCaseModel : UseCaseDiagram`
7. Do not proceed until the library itself passes.
8. Load `StructuredUseCases_TestSuite_matching.sysml` in the SysML v2 Textual Editor.
9. Synchronize the test suite using `Alt+S`.
10. Verify that the test suite compiles without errors.
11. Verify in the Containment tree that the test suite contains usages typed by:
    - `Actor`
    - `Step`
    - `Scenario`
    - `UseCase`
    - `Association`
    - `UseCaseDiagram`
12. Verify that multiple Actors, UseCases, Associations, Scenarios, and Steps can coexist in the test package.
13. Verify that `secondUseCaseDiagram : UseCaseDiagram` resolves correctly.
14. Record PASS if the library and test suite compile, synchronize, and resolve all types correctly.
15. Record FAIL if Cameo reports a compilation, synchronization, import, or type-resolution error.

## Important Rule

Do not change the library merely to make the test suite pass.

The uploaded `UC_Lib.sysml` is the known-working baseline. Since this version changes only the package name, any new failure should first be investigated as a package-name/import issue or a test-harness issue.
