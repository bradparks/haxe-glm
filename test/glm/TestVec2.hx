package glm;

import buddy.*;
using buddy.Should;
import glm.Vec2;

class TestVec2 extends BuddySuite {
	public function new() {
		describe('Using Vec2s', {
			var v:Vec2;
			beforeEach({
				v = new Vec2();
			});

			it("should create zero vectors", {
				v.zero();
				for(i in 0...2) {
					v[i].should.beCloseTo(0);
				}
			});
			it("should provide .xy access", {
				v.x = 1;
				v.x.should.be(1);
				v.y = 2;
				v.y.should.be(2);
			});
			it("should provide .st access", {
				v.s = 1;
				v.s.should.be(1);
				v.t = 2;
				v.t.should.be(2);
			});
			it("should calculate the length (2-norm) of a vector", {
				v.set(3, 4);
				v.length().should.beCloseTo(5);
			});
			it("should normalize a vector with a magnitude > 0", {
				v.set(3, 4);
				v.normalize();
				v[0].should.beCloseTo(0.6);
				v[1].should.beCloseTo(0.8);
			});
			it("shouldn't crash when normalizing a vector with a magnitude of 0", {
				v.zero();
				v.normalize.bind().should.not.throwType(String);
			});
			it("should respect scalar math", {
				v.set(1, 2);
				v *= 2;
				v[0].should.beCloseTo(2);
				v[1].should.beCloseTo(4);

				var b:Vec2 = v / 2;
				b[0].should.beCloseTo(1);
				b[1].should.beCloseTo(2);

				v /= 2;
				b = 3 * v;
				b[0].should.beCloseTo(3);
				b[1].should.beCloseTo(6);

				b = v + 0.5;
				b[0].should.beCloseTo(1.5);
				b[1].should.beCloseTo(2.5);

				b = 0.5 + v;
				b[0].should.beCloseTo(1.5);
				b[1].should.beCloseTo(2.5);

				b = v - 0.5;
				b[0].should.beCloseTo(0.5);
				b[1].should.beCloseTo(1.5);

				b = 0.5 - v;
				b[0].should.beCloseTo(-0.5);
				b[1].should.beCloseTo(-1.5);
			});
			it("should be able to add and subtract other vectors", {
				v.set(1, 2);
				v += new Vec2(0.25, 0.5);
				v[0].should.beCloseTo(1.25);
				v[1].should.beCloseTo(2.5);

				v -= new Vec2(0.25, 0.5);
				v[0].should.beCloseTo(1);
				v[1].should.beCloseTo(2);
			});
			it('should flatten into an array', {
				v.set(1, 2);
				var res:Array<Float> = v.toArray();
				for(i in 0...2) {
					res[i].should.beCloseTo(v[i]);
				}
			});
			it('should calculate the dot product of two vectors', {
				v.set(1, 2);
				var b:Vec2 = v.clone();
				var d:Float = Vec2.dot(v, b);
				d.should.beCloseTo(5);
			});
			it('should cast itself from Vec3s and Vec4s', {
				var v3:Vec3 = new Vec3(1, 2, 3);
				var v4:Vec4 = new Vec4(4, 5, 6, 7);
				
				v = v3;
				v.x.should.beCloseTo(1);
				v.y.should.beCloseTo(2);
				
				v = v4;
				v.x.should.beCloseTo(4);
				v.y.should.beCloseTo(5);
			});
			it('should be serializable', {
				v.set(1, 2);

				var s:haxe.Serializer = new haxe.Serializer();
				s.serialize(v);
				var serialized:String = s.toString();

				var u:haxe.Unserializer = new haxe.Unserializer(serialized);
				var v2:Vec2 = u.unserialize();
				
				for(i in 0...2) {
					v2[i].should.beCloseTo(v[i]);
				}
			});
			it('should provide linear interpolation', {
				v.set(1, 2);
				var b:Vec2 = v.clone().lerp(v.clone() * 4, 0.75);
				for(i in 0...2) {
					b[i].should.beCloseTo(0.75 * (v[i] * 3) + v[i]);
				}
			});

			afterEach({
				v = null;
			});
		});
	}
}