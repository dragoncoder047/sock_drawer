class Foo:
    def __init__(self):
        self.inside = False

    def __enter__(self):
        print("Foo enter self.inside =", self.inside)
        def temp(self, exc, val, tb, old=self.inside):
            print("Foo exit old self.inside =", old)
            self.inside = old
        self.__exit__ = temp
        self.inside = True
        return self


x = Foo()
with x:
    with x:
        with x:
            print("Inner with statement body")
# AttributeError: __exit__
