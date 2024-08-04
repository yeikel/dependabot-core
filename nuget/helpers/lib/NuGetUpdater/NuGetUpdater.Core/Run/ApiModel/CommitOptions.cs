namespace NuGetUpdater.Core.Run.ApiModel;

public record CommitOptions
{
    public string? Prefix { get; init; } = null;
    public string? PrefixDevelopment { get; init; } = null;
    public string? IncludeScope { get; init; } = null;
}