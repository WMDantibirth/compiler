package com.jxtxzzw.compiler;

// import ANTLR's runtime libraries

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import resources.ExpressionTestLexer;
import resources.ExpressionTestParser;


import java.io.*;

public class Compiler {
    public static void main(String[] args) throws Exception {
        InputStream cx = new BufferedInputStream(new FileInputStream("test.cx"));
        @SuppressWarnings("deprecation")
        ANTLRInputStream input = new ANTLRInputStream(cx);
        ExpressionTestLexer lexer = new ExpressionTestLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        ExpressionTestParser parser = new ExpressionTestParser(tokens);

        ParseTree tree = parser.r();

        Program p = new Program();
        p.buildAbstractSyntaxTree(tree);

        BufferedWriter bw = new BufferedWriter(new FileWriter(new File("test.p")));
        bw.write(p.outputCode());
        bw.close();

    }
}
