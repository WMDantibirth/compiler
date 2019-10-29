package com.jxtxzzw.compiler.ast;

import com.jxtxzzw.compiler.symboltable.Symbol;

public class VariableExpression extends Expression {
    private Symbol symbol;
    VariableExpression(Symbol symbol) {
        super(symbol.getBeseType());
        this.symbol = symbol;
    }

    public Symbol getSymbol() {
        return this.symbol;
    }

    @Override
    public String compile() {
        return null;
    }
}
