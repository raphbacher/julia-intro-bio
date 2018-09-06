using InteractiveUtils

function _strip_comments(out::IO, inp::IO)
    for ln in eachline(inp)
        if !startswith(ln, ';')
            println(out, ln)
        end
    end
end

function code_native_nocomment(
    io::IO, @nospecialize(f), @nospecialize(types=Tuple);
    syntax::Symbol = :intel)

    tmpio = IOBuffer()
    code_native(tmpio, f, types, syntax=syntax)
    seekstart(tmpio)
    _strip_comments(io, tmpio)
end

code_native_nocomment(
    @nospecialize(f), @nospecialize(types=Tuple); syntax::Symbol = :att) =
        code_native_nocomment(stdout, f, types, syntax = syntax)

code_native_nocomment(::IO, ::Any, ::Symbol) =
    error("illegal code_native call") # resolve ambiguous call

function code_llvm_nocomment(
    io::IO, @nospecialize(f), @nospecialize(types=Tuple),
    strip_ir_metadata=true, dump_module=false, optimize=true)

    tmpio = IOBuffer()
    code_llvm(tmpio, f, types, strip_ir_metadata, dump_module, optimize)
    seekstart(tmpio)
    _strip_comments(io, tmpio)
end

code_llvm_nocomment(
    @nospecialize(f), @nospecialize(types=Tuple);
    raw=false, dump_module=false, optimize=true) =
        code_llvm_nocomment(stdout, f, types, !raw, dump_module, optimize)

macro code_native_nocomment(ex0)
    InteractiveUtils.gen_call_with_extracted_types(
        __module__, :code_native_nocomment, ex0)
end

macro code_llvm_nocomment(ex0)
    InteractiveUtils.gen_call_with_extracted_types(
        __module__, :code_llvm_nocomment, ex0)
end