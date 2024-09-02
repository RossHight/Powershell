$a="forks_count"
$b=(irm "https://api.github.com/orgs/PowerShell/repos"|sort $a|select -La 1)
echo "The repository with the most forks is: $($b.name) with $($b.$a) forks."