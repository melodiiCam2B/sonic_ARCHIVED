package utils.track;
using StringTools;
using Lambda;
class Info{

    public static macro  function getNum():haxe.macro.Expr.ExprOf<String>{
		var nproc = new sys.io.Process('git', ['rev-list', 'HEAD', '--count'], false);
		var commitNumn:String = "";
		try {
			commitNumn = nproc.stdout.readLine();
			nproc.exitCode(true);
		}catch (e){}

        return macro  $v{commitNumn};
    }

    public static macro  function getHash():haxe.macro.Expr.ExprOf<String>{
		var cproc = new sys.io.Process('git', ['rev-parse', '--short', 'HEAD'], false);
		var commitHash:String = "";
		try {
            commitHash = cproc.stdout.readLine();
            cproc.exitCode(true);
		}catch (e){}

        return macro  $v{commitHash};
    }
    public static macro  function getBranch():haxe.macro.Expr.ExprOf<String>{
		var bproc = new sys.io.Process('git', ['rev-parse', '--abbrev-ref', 'HEAD']);
		var branchName:String = "";
		try {
			branchName = bproc.stdout.readLine();
			bproc.exitCode(true);
		}catch (e){}

        return macro  $v{branchName};
    }
	public static function getAll(){
        return '${getNum()}, ${getHash()}, ${getBranch()}';
    }
    public static function getGit(){
        return 'depricated, use getAll';
    }
}