class Wren < Formula
  desc "The Wren Programming Language"
  homepage "https://wren.io"
  url "https://github.com/wren-lang/wren-cli/archive/0.3.0.tar.gz"
  sha256 "a498d2ccb9a723e7163b4530efbaec389cc13e6baaf935e16cbd052a739b7265"

  resource("wren") do
    url "https://github.com/wren-lang/wren/archive/0.3.0.tar.gz"
    sha256 "c566422b52a18693f57b15ae4c9459604e426ea64eddb5fbf2844d8781aa4eb7"
  end

  def install
    wren = buildpath/"deps/wren"

    rm_rf wren
    resource("wren").stage wren
    system "make", "-C", wren/"projects/make.mac", "verbose=1"

    mv wren/"src/include", wren/"include"
    system "make", "-C", "projects/make.mac", "verbose=1"

    bin.install "bin/wren_cli" => "wren"
    lib.install Dir[wren/"lib/*"]
    include.install Dir[wren/"include/*"]
    pkgshare.install wren/"example"
  end

  test do
    (testpath/"hello.wren").write <<~EOS
      System.print("Hello, world!")
    EOS
    assert_equal "Hello, world!\n", shell_output("#{bin}/wren hello.wren")

    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <stdio.h>
      #include "wren.h"

      int main()
      {
        WrenConfiguration config;
        wrenInitConfiguration(&config);
        WrenVM* vm = wrenNewVM(&config);
        WrenInterpretResult result = wrenInterpret(vm, "test", "var result = 1 + 2");
        assert(result == WREN_RESULT_SUCCESS);
        wrenEnsureSlots(vm, 0);
        wrenGetVariable(vm, "test", "result", 0);
        printf("1 + 2 = %d\\n", (int) wrenGetSlotDouble(vm, 0));
        wrenFreeVM(vm);
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lwren", "-o", "test"
    assert_equal "1 + 2 = 3", shell_output("./test").strip
  end
end
